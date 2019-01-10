docker build -t ryanmcalister/multi-client:latest -t ryanmcalister/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ryanmcalister/multi-server:latest -t ryanmcalister/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ryanmcalister/multi-worker:latest -t ryanmcalister/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ryanmcalister/multi-client:latest
docker push ryanmcalister/multi-server:latest
docker push ryanmcalister/multi-worker:latest
docker push ryanmcalister/multi-client:$SHA
docker push ryanmcalister/multi-server:$SHA
docker push ryanmcalister/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ryanmcalister/multi-server:$SHA
kubectl set image deployments/client-deployment client=ryanmcalister/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ryanmcalister/multi-worker:$SHA
