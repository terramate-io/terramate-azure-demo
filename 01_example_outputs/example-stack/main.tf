resource "null_resource" "example_1" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo 'Hello from null resource 1'"
  }
}

resource "null_resource" "example_2" {
  triggers = {
    file_hash = filemd5("${path.module}/main.tf")
  }

  provisioner "local-exec" {
    command = "echo 'File hash trigger example'"
  }
}

resource "null_resource" "example_3" {
  count = 2

  triggers = {
    instance = "${count.index}"
  }

  provisioner "local-exec" {
    command = "echo 'Null resource instance ${count.index}'"
  }
}

resource "null_resource" "example_4" {
  triggers = {
    dependency = "some-value"
  }

  provisioner "local-exec" {
    command     = "sleep 5 && echo 'Delayed execution complete'"
    working_dir = path.module
  }
}

resource "null_resource" "example_5" {
  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    uuid = uuidv4()
  }

  provisioner "local-exec" {
    command = "echo 'UUID-triggered null resource with lifecycle management'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Cleanup on destroy'"
  }
}
