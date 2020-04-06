from storages.backends.s3boto3 import S3Boto3Storage


class PrivateStorage(S3Boto3Storage):
    location = "private"
    file_overwrite = False
    custom_domain = False
