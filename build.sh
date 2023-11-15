#!/bin/bash
cd graph-app
sudo docker build -t graph-app .
sudo docker tag graph-app localhost:5000/graph-app
sudo docker push  localhost:5000/graph-app

echo "Finalizado"
