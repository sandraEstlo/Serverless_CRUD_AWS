import json
import boto3
import uuid
from boto3.dynamodb.conditions import Key

dynamodb = boto3.resource('dynamodb')
table    = dynamodb.Table('Products')

def lambda_handler(event, context):

    http_method = event['httpMethod']
    path_parameters = event.get('pathParameters', {})
    
    if http_method == 'GET':
        if path_parameters and 'id' in path_parameters : 
            return get_product(path_parameters['id'])
        else: return list_products()
    
    elif http_method == 'POST' or http_method == 'PUT':
        requestBody = json.loads(event['body'])
        return create_or_update_product(http_method, requestBody)
    
    elif http_method == 'DELETE' and path_parameters and 'id' in path_parameters:
        return delete_product(path_parameters['id'])
    
    else: 
        return {
            'statusCode': 404,
            'body': json.dumps({'message': 'Error'})
        }

def get_product(product_id):
    response = table.get_item(Key={'id': product_id})
    item = response.get('Item')
    
    if not item:
        return {
            'statusCode': 404,
            'body': json.dumps({'message': 'Product not found'})
        }

    return {
        'statusCode': 200,
        'body': json.dumps(item)
    }

def list_products():
    response = table.scan()

    return { 
        'statusCode': 200, 
        'body': json.dumps(response.get('Items', [])) 
    }

def create_or_update_product(http_status, data):
    operation = 'create' if http_status == 'POST' else 'update'
    response_satatus = 201 if http_status == 'POST' else 200

    table.put_item(Item = data)
    response = table.get_item(Key={'id': data['id']})

    body = {
        'Operation': operation.upper(),
        'Message': f'Product {operation}d successfully',
        'Product': response.get('Item')
    }

    return { 
        'statusCode': response_satatus, 
        'body': json.dumps(body) 
    }

def delete_product(product_id):
    table.delete_item(Key={'id': product_id})
    return { 
        'statusCode': 200, 
        'body': json.dumps({'message': 'Product deleted successfully'}) 
    }