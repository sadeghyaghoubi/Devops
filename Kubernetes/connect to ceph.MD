*****on ceph node****
$ceph auth get client.admin
[client.admin]
        key = AQBpvs5n4i7wFBAA/pjiwmgxyChP+t3w==
        caps mds = "allow *"
        caps mgr = "allow *"
        caps mon = "allow *"
        caps osd = "allow *"


#copy key and convert to base64 and edit csi-rbd-secret.yaml (for userKey , adminKey)
#userID and adminId are admin

******on kubernetes*******
#edit csi-rbd-secret.yaml
---
apiVersion: v1
kind: Secret
metadata:
  name: csi-rbd-secret
  namespace: ceph 
stringData:
  userID: YWtaW4=
  userKey: QVFCcHZzNW40aTd3RkJaml3bWd4eTRaZmpaR0NoUCt0M3c9PQ==
  adminID: YWRtaW4=
  adminKey: QVFCcHZzNW40aTBQS9waml3bWd4eTRaZmpaR0NoUCt0M3c9PQ==

---------------
#edit StorageClass (sc-cephfs-hdd.yaml) and 
remove this fields from yaml and apply sc-cephfs-hdd.yaml. 
1.allowVolumeExpansion
2.mountOptions

----------------
#edit csi-config-map.yaml and change (clusterID , monitors) and then apply csi-config-map.yaml
#on ceph node copy output of "ceph fsid" command and paste to clusterID
#monitors are ceph ip address
  config.json: |-
    [
      {
        "clusterID": "29bc08f6-fd9a-11ef-909d-0050569ac7e0",
        "monitors": [
          "192.168.59.x1:6789",
          "192.168.59.x2:6789",
          "192.168.59.x3:6789"
        ]
      }



***************************
finally
> kubectl apply -f ceph/*




*************test*****************

#create pvc (kubectl apply -f pvc.yaml)
#edit pvc.yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  finalizers:
  - kubernetes.io/pvc-protection
  name: apigw
  namespace: app
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
  storageClassName: cephfs-hdd
  volumeMode: Filesystems

#Get pvc (kubectl get pvc -n app)

[root@master1 ~]# kubectl get pvc -n app
NAME      STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
apigw   Bound    pvc-e60ce09a-47df-4b21-b7c6-a913b0df52c0   1Gi        RWX            cephfs-hdd     <unset>                 60m





#use the pvc in deployments
#edit app.deployment and add volumes 
      volumes:
      - name: apigw
        persistentVolumeClaim:
          claimName: apigw

        volumeMounts:
        - mountPath: /opt/apigw/config/apigw/
          name: apigw
          subPath: doc



end.




