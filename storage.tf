resource "aws_s3_bucket" "ajaybucket31394" {
	bucket = var.bucket_name

	tags = {
	Name = var.bucket_tag
	Environment = "Dev"
}
}

resource "aws_s3_bucket_ownership_controls" "ajay" {
bucket = aws_s3_bucket.ajaybucket31394.id
rule {
 object_ownership = "BucketOwnerPreferred"
}
}

resource "aws_s3_bucket_acl" "ajay_bucket_acl" {
	depends_on = [aws_s3_bucket_ownership_controls.ajay]

	bucket = aws_s3_bucket.ajaybucket31394.id
	acl = var.bucket_acl
}


