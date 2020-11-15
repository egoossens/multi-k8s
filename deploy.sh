docker build -t egoossens/multi-client:latest -t egoossens/multi-client:"$SHA" -f ./client/Dockerfile ./client
docker build -t egoossens/multi-server:latest -t egoossens/multi-server:"$SHA" -f ./server/Dockerfile ./server
docker build -t egoossens/multi-worker:latest -t egoossens/multi-worker:"$SHA" -f ./worker/Dockerfile ./worker
docker push egoossens/multi-client:latest
docker push egoossens/multi-server:latest
docker push egoossens/multi-worker:latest
docker push egoossens/multi-client:"$SHA"
docker push egoossens/multi-server:"$SHA"
docker push egoossens/multi-worker:"$SHA"
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=egoossens/multi-client:"$SHA"
kubectl set image deployments/server-deployment server=egoossens/multi-server:"$SHA"
kubectl set image deployments/worker-deployment worker=egoossens/multi-worker:"$SHA"
