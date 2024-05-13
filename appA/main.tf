module "appAInfra" {
  source = "../lambda_module"
  lambda_function_name = var.lambdaFunc
  iam_role_name = var.iamRole
  handler = var.handler
  filename = data.archive_file.example.output_path
}

data "archive_file" "example" {
  type        = "zip"
  source_file = "login.py"
  output_path = "login.zip"
}
