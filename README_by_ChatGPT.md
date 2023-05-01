# GCP Cloud Run IDE Server

This is a sample project that demonstrates how to deploy a web-based IDE (Integrated Development Environment) on Google Cloud Run using the Eclipse Che platform. With this setup, you can easily spin up a containerized development environment that can be accessed from anywhere with an internet connection.

## Getting Started

### Prerequisites

To run this project, you will need:

- A Google Cloud Platform account
- The [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed on your local machine
- Docker installed on your local machine
- A GitHub account

### Installing

To install and run this project, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the project directory and run the following command to build the Docker image:

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

1. Fork this repository to your own GitHub account.
2. Open the [Google Cloud Console](https://console.cloud.google.com/).
3. Create a new project or select an existing one.
4. Open the Cloud Shell by clicking the icon in the top right corner of the console.
5. Clone your forked repository using the following command:

```bash
git clone https://github.com/[YOUR_GITHUB_USERNAME]/gcp-cloud-run-ide-server.git
```

6. Navigate to the project directory:

```bash
cd gcp-cloud-run-ide-server
```

7. Build the Docker image and push it to Google Container Registry (GCR) by running the following commands:

```bash
docker build -t gcr.io/[PROJECT_ID]/[DOCKER_IMAGE_NAME] .
docker push gcr.io/[PROJECT_ID]/[DOCKER_IMAGE_NAME]
```

Make sure to replace `[PROJECT_ID]` with the ID of your Google Cloud project and `[DOCKER_IMAGE_NAME]` with a name for your Docker image.

8. Deploy the container to Google Cloud Run using the following command:

```bash
gcloud run deploy --image gcr.io/[PROJECT_ID]/[DOCKER_IMAGE_NAME] --platform managed --region [REGION] --port 8080 --allow-unauthenticated [SERVICE_NAME]
```

Replace `[REGION]` with the region you want to deploy to (e.g. `us-central1`) and `[SERVICE_NAME]` with a name for your Cloud Run service.

9. After the deployment is complete, you can access the IDE by navigating to the Cloud Run URL provided in the output of the deployment command.

## Contributing

Contributions to this project are welcome. To contribute, please fork this repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
