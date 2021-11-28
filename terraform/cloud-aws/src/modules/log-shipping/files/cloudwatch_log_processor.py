import base64
import gzip
import io
import json
import zlib

def lambda_handler(event, context):
    output = []
    data_only = ""

    for record in event['records']:
        compressed_payload = base64.b64decode(record['data'])
        uncompressed_payload = json.loads(gzip.GzipFile(fileobj=io.BytesIO(compressed_payload)).read())
        print('uncompressed_payload',uncompressed_payload)


        data_only = json.dumps(uncompressed_payload)
        output_record = {
            'recordId': record['recordId'],
            'result': 'Ok',
            'data': base64.b64encode(data_only + "CWRECORDSEPARATOR")
        }
        output.append(output_record)

    print('Successfully processed {} records.'.format(len(event['records'])))

    return {'records': output}