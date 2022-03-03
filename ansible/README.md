# Ansible Playbooks

FMADIO Packet Capture System Ansible Playbooks


## capstart.yml

Starts a Quick Capture

```
ansible-playbook capstart.yml 
```

NOTE: this can fail an existing capture is already runngin 


## capstop.yml

Stops a Quick Capture


```
ansible-playbook capstop.yml 
```

NOTE: this can fail if the capture is running using the Scheduler 


## capstatus.yml

Gets the status of the current captuyre system 


```
ansible-playbook capstatus.yml 
```

