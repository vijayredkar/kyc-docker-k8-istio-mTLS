cd  /c/Vijay/Java/projects/kyc-k8-docker-istio/networking

echo "                        "
echo "------------------minikube delete--------------------------"
minikube delete


echo "                        "
echo "------------------minikube stop--------------------------"
minikube stop

echo "                        "
echo "------------------minikube start--------------------------"
minikube start --driver=docker

echo "                        "
echo "------------------docker login--------------------------"
docker login

echo "                        "
echo "------------------minikube docker-env--------------------------"
minikube docker-env


echo "                        "
echo "------------------istioctl install --set profile=demo -y--------------------------"
istioctl install --set profile=demo -y
echo "---kubectl label"

echo "                        "
echo "------------------kubectl label namespace default istio-injection=enabled--------------------------"
kubectl label namespace default istio-injection=enabled


echo "                        "
echo "------------------Gateway IP - minikube ip--------------------------"
minikube ip


echo "                        "
echo "------------------Istio Port - kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}'--------------------------"
kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}'


echo "                        "
echo "------------------Update kyc-aggregator-mgt application with  Gateway IP--------------------------"

echo "                        "
echo "------------------Update kyc-aggregator-mgt application with  Istio Port--------------------------"


