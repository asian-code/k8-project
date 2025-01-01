* used Choco to isntall kubectl and helm charts (package of pre-configured Kubernetes resources that can be deployed as a single unit. Helm is often referred to as the "package manager for Kubernetes" because it simplifies the process of managing Kubernetes applications.)

after EKS setup use : `aws eks update-kubeconfig --region <your-region> --name <cluster-name>`
to access the cluster with kubectl 

install promethus + grafana into the cluster
`helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus //needs to be connected to cluster to run
helm install grafana grafana/grafana //needs to be connected to cluster to run
`

Install AquaSec
`helm repo add aquasecurity https://aquasecurity.github.io/helm-charts/
helm repo update
helm install aqua-kube-bench aquasecurity/kube-bench
`

develop and containerize microservices
deploy to kubernetes
setup ingress controller


. Set Up CI/CD Pipeline
Automate deployment using GitHub Actions or Jenkins:
Build Docker images.
Push to a container registry (e.g., Amazon ECR).
Deploy to Kubernetes with kubectl or Helm.
Add container image scans to your CI/CD pipeline using AquaSec Trivy.
### CI Stage:
Builds the Docker image.
Pushes it to DockerHub.
Scans the image for vulnerabilities using Trivy.
### CD Stage:
Lints Helm charts for syntax and best practices.
Deploys Prometheus, Grafana, and your app to the Kubernetes cluster using Helm.

## ECR provides command to use for pushing images to it
for linux: 
* aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/t0q0g8s3
* docker build -t ericr .
* docker tag ericr:latest public.ecr.aws/t0q0g8s3/ericr:latest
* docker push public.ecr.aws/t0q0g8s3/ericr:latest
---



