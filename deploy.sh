docker build -t deodatus/k8s-test-multi-client:latest -t deodatus/k8s-test-multi-client:$SHA  -f ./complex/client/Dockerfile ./complex/client
docker build -t deodatus/k8s-test-multi-server:latest -t deodatus/k8s-test-multi-server:$SHA -f ./complex/server/Dockerfile ./complex/server
docker build -t deodatus/k8s-test-multi-worker:latest -t deodatus/k8s-test-multi-worker:$SHA -f ./complex/worker/Dockerfile ./complex/worker

docker push deodatus/k8s-test-multi-client:latest
docker push deodatus/k8s-test-multi-server:latest
docker push deodatus/k8s-test-multi-worker:latest

docker push deodatus/k8s-test-multi-client:$SHA
docker push deodatus/k8s-test-multi-server:$SHA
docker push deodatus/k8s-test-multi-worker:$SHA

kubectl apply -f complex/k8s

kubectl set image deployments/client-deployment client=deodatus/k8s-test-multi-client:$SHA
kubectl set image deployments/server-deployment server=deodatus/k8s-test-multi-server:$SHA
kubectl set image deployments/worker-deployment worker=deodatus/k8s-test-multi-worker:$SHA
