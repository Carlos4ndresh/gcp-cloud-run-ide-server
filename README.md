# GCP Cloud Run IDE Server

This is a sample project that demonstrates how to deploy a web-based IDE (Integrated Development Environment) on [Google Cloud Run](https://cloud.google.com/run) using the Coder Code-Server [Code-Server](https://github.com/coder/code-server). With this setup, you can easily spin up a containerized development environment that can be accessed from anywhere with an internet connection.

However, you must take into consideration that running this on a CloudRun container has significant considerations:

- You dont have permanent storage, so everytime you refresh you lose your changes
- You don't have authentication. Coder authentication is disabled so full anonymous access is allowed.
- Coder doesn't have the same extensions as VSCode Server nor syncs with your Github or MS Account. So you probably won't find certain things.

This project is intended as my testing ground for GCP services. So I expect to solve first two and add more services. Also, you cold use [VSCode Server](https://code.visualstudio.com/docs/remote/vscode-server) but it's a bit trickier and ambiguous in licensing.

Final note: this project creates several resources that can incur in expenses around 40-50 USD monthly, so if you're not ready to pay that, please avoid to create any of these resources.

## Getting Started

### Prerequisites

To run this project, you will need:

- A Google Cloud Platform account
- A GCP Project
- The [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed on your local machine
- Docker installed on your local machine
- An up to date Terraform CLI installation, and authentication/credentials to GCP and other cloud providers you need to use.
- A GitHub account

### Installing

To install and run this project, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the `container` directory and run the following command to build the Docker image:

```bash
docker build -t [DOCKER_IMAGE_NAME] .
```

3. Once the Docker image is built, you can run it locally using the following command:

```bash
docker run -it -p 8080:8080 [DOCKER_IMAGE_NAME]
```

4. Open a web browser and navigate to `http://localhost:8080` to access the IDE.

### Deploying to Google Cloud Run

To deploy this project to Google Cloud Run, follow these steps:

1. Fork this repository to your own GitHub account, clone it locally or if you prefer Cloud Shell, but be mindful that you'll need to run Terraform commands, and therefore, authenticate Terraform to GCP.

2. Navigate to the `terraform\artifact_registry` folder.

3. Be sure to modify your Terraform backend information to match what you'll use for yours, also to login to GCP/provide credentials.

4. Before running the Terraform operations `(init, plan, apply)`, be sure of the name and region of the artifact registry. As you may noticed, I'm using Artifact registry instead of Container Registry, as the former is the strategic product for storing container images. More Info: <https://cloud.google.com/container-registry/docs/overview>. Also, the region where you create the registry, must be the same as the one where Cloud Run containers will be executed.

5. Create the artifact registry using Terraform.

6. Build the Docker image and push it to Artifact Registry by running the following commands:

```bash
docker build -t us-west4-docker.pkg.dev/[PROJECT_ID]/[DOCKER_IMAGE_NAME] . # Be sure that region,project-id and image name you gave matches
docker push us-west4-docker.pkg.dev/[PROJECT_ID]/[DOCKER_IMAGE_NAME]
```

Make sure to replace `[PROJECT_ID]` with the ID of your Google Cloud project and `[DOCKER_IMAGE_NAME]` with a name for your Docker image. This includes the folder prefix, take a look at `terraform\cloud_run\main.tf`.

7. Go to the `terraform\cloud_run` folder, in there, the Terraform Code will create all necessary objects to deploy the container to cloud run and make it available to the Internet:

- Cloud Run Service
- Authentication Policy (NOAUTH)
- Global HTTPS Load Balancer and Certificates. Certificate Creation requires a previous validation of domain ownership, I did it via GCP Cloud Identity/Organization.
- DNS entry. I'm using route53 as it's where my domain public hosted zone sits and to show how you can manage resources in more than one cloud provider using the same terraform code/module.

NOTE: Change domain names, and domain information to fit your setup.

8. After Terraform completes, you can browse to the URL/path you defined to see the code server in action.

## Contributing

Contributions to this project are welcome. To contribute, please fork this repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
