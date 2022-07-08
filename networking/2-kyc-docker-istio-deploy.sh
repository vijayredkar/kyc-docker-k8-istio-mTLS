cd  /c/Vijay/Java/projects/kyc-k8-docker-istio/kyc-aggregator-mgt
echo "------------------docker rmi--------------------------"
docker rmi kyc-aggregator-mgt:latest
echo "------------------docker rmi--------------------------"
docker rmi -f kyc-aggregator-mgt:latest | docker rmi -f vijayredkar/kyc-aggregator-mgt:latest
echo "------------------mvn clean install--------------------------"
mvn clean install
echo "------------------docker build kyc-aggregator-mgt--------------------------"
docker build -t kyc-aggregator-mgt -f Dockerfile .
echo "------------------docker image ls--------------------------"
docker image ls
echo "------------------docker tag--------------------------"
docker tag  kyc-aggregator-mgt vijayredkar/kyc-aggregator-mgt:latest
echo "------------------docker push--------------------------"
docker push vijayredkar/kyc-aggregator-mgt
echo "------------------kubectl delete service kyc-aggregator-mgt--------------------------"
kubectl delete service kyc-aggregator-mgt
echo "------------------kubectl delete deployment kyc-aggregator-mgt--------------------------"
kubectl delete deployment kyc-aggregator-mgt


cd  /c/Vijay/Java/projects/kyc-k8-docker-istio/kyc-credit-check-basic
echo "---------docker rmi--------------------------"
docker rmi -f kyc-credit-check-basic:latest
echo "---------docker rmi--------------------------"
docker rmi -f vijayredkar/kyc-credit-check-basic:latest
echo "---------mvn clean install--------------------------"
mvn clean install
echo "---------docker build kyc-credit-check-basic--------------------------"
docker build -t kyc-credit-check-basic -f Dockerfile .
echo "---------docker image ls--------------------------"
docker image ls
echo "---------docker tag--------------------------"
docker tag  kyc-credit-check-basic vijayredkar/kyc-credit-check-basic:latest
echo "---------docker push--------------------------"
docker push vijayredkar/kyc-credit-check-basic
echo "---------kubectl delete service kyc-credit-check-basic--------------------------"
kubectl delete service kyc-credit-check-basic
echo "---------kubectl delete deployment kyc-credit-check-basic--------------------------"
kubectl delete deployment kyc-credit-check-basic



cd  /c/Vijay/Java/projects/kyc-k8-docker-istio/kyc-credit-check-advanced
echo "---------docker rmi--------------------------"
docker rmi -f kyc-credit-check-advanced:latest
echo "---------docker rmi--------------------------"
docker rmi -f vijayredkar/kyc-credit-check-advanced:latest
echo "---------mvn clean install--------------------------"
mvn clean install
echo "---------docker build kyc-credit-check-advanced--------------------------"
docker build -t kyc-credit-check-advanced -f Dockerfile .
echo "---------docker image ls--------------------------"
docker image ls
echo "---------docker tag--------------------------"
docker tag  kyc-credit-check-advanced vijayredkar/kyc-credit-check-advanced:latest
echo "---------docker push--------------------------"
docker push vijayredkar/kyc-credit-check-advanced
echo "---------kubectl delete service kyc-credit-check-advanced--------------------------"
kubectl delete service kyc-credit-check-advanced
echo "---------kubectl delete deployment kyc-credit-check-advanced--------------------------"
kubectl delete deployment kyc-credit-check-advanced



echo "---------Clean up existing references---------"

echo "---kubectl delete service kyc-aggregator-mgt"
kubectl delete service kyc-aggregator-mgt
echo "---kubectl delete deployment kyc-aggregator-mgt"
kubectl delete deployment kyc-aggregator-mgt
echo "---kubectl delete gateway kyc"
kubectl delete gateway kyc
echo "---kubectl delete virtualservice kyc"
kubectl delete virtualservice kyc
echo "---kubectl delete destinationrule kyc-aggregator-mgt"
kubectl delete destinationrule kyc-aggregator-mgt

echo "---kubectl delete service kyc-credit-check-basic"
kubectl delete service kyc-credit-check-basic
echo "---kubectl delete deployment kyc-credit-check-basic"
kubectl delete deployment kyc-credit-check-basic
echo "---kubectl delete gateway kyc credit check"
kubectl delete gateway kyc-credit-check
echo "---kubectl delete virtualservice kyc credit check"
kubectl delete virtualservice kyc-credit-check
echo "---kubectl delete destinationrule kyc-credit-check-basic"
kubectl delete destinationrule kyc-credit-check-basic

echo "---kubectl delete service kyc-credit-check-advanced"
kubectl delete service kyc-credit-check-advanced
echo "---kubectl delete deployment kyc-credit-check-advanced"
kubectl delete deployment kyc-credit-check-advanced
echo "---kubectl delete gateway kyc credit check"
kubectl delete gateway kyc-credit-check
echo "---kubectl delete virtualservice kyc credit check"
kubectl delete virtualservice kyc-credit-check
echo "---kubectl delete destinationrule kyc-credit-check-advanced"
kubectl delete destinationrule kyc-credit-check-advanced




echo "-------Create new artifacts--------------------"
echo "---kubectl apply kyc aggreg mgt istio yml"
kubectl apply -f /c/Vijay/Java/projects/kyc-k8-docker-istio/networking/kyc-aggregator-mgt-k8-istio.yml
echo "---kubectl apply kyc aggreg mgt istio gateway yml"
kubectl apply -f /c/Vijay/Java/projects/kyc-k8-docker-istio/networking/kyc-aggregator-mgt-istio-routing.yaml
echo "---kubectl apply kyc aggreg mgt istio destination-rule yml"
kubectl apply -f /c/Vijay/Java/projects/kyc-k8-docker-istio/networking/kyc-aggregator-mgt-destination-rule.yaml


echo "---kubectl apply kyc credit check istio yml"
kubectl apply -f /c/Vijay/Java/projects/kyc-k8-docker-istio/networking/kyc-credit-check-basic-k8-istio.yml
echo "---kubectl apply kyc credit check istio destination-rule yml"
kubectl apply -f /c/Vijay/Java/projects/kyc-k8-docker-istio/networking/kyc-credit-check-basic-destination-rule.yaml


echo "---kubectl apply kyc credit check istio yml"
kubectl apply -f /c/Vijay/Java/projects/kyc-k8-docker-istio/networking/kyc-credit-check-advanced-k8-istio.yml
echo "---kubectl apply kyc credit check istio destination-rule yml"
kubectl apply -f /c/Vijay/Java/projects/kyc-k8-docker-istio/networking/kyc-credit-check-advanced-destination-rule.yaml


echo "---kubectl apply kyc credit check istio gateway - virtual service yml"
kubectl apply -f /c/Vijay/Java/projects/kyc-k8-docker-istio/networking/kyc-credit-check-istio-routing.yaml



echo "---------Verifications----------"

echo "---------docker image ls"
docker image ls
echo "---------kubectl get pods"
kubectl get pods
echo "---------kubectl get services"
kubectl get services
echo "--------- kubectl get deployments"
kubectl get deployments
echo "--------- kubectl get virtualservices"
kubectl get virtualservices
echo "--------- kubectl get gateways"
kubectl get gateways
echo "--------- kubectl get destinationrules"
kubectl get destinationrules
echo "--------- kubectl get ingress"
kubectl get ingress



echo "--------- sleeping 15m to allow pods to be ready"
sleep 15m

echo "--------- port forwarding..."
export POD_NAME=$(kubectl get pods --no-headers -o custom-columns=":metadata.name"  --selector app=kyc-aggregator-mgt)
kubectl port-forward $POD_NAME 8080:8080
