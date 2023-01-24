# Dockerize
Write a Dockerfile to run Cosmos Gaia v7.1.0 (https://github.com/cosmos/gaia) in a container. It should download the source code, build it and run without any modifiers (i.e. docker run somerepo/gaia:v7.1.0 should run the daemon) as well as print its output to the console. The build should be security conscious (and ideally pass a container image security test such as Anchor). [20 pts]

## Answer
I created the docker file **Dockerfile** that did the following ([Image found here](https://hub.docker.com/r/tinstar71/hire-me-plz))
- Run Cosmos Gaia v.7.1.0
	-  Lines 14, 20 clone and checkout the v.7.1.0 version of the software. 
-  Build and run without any modifiers and prints out to the console
	-  Line 26 installs the software and line 38 runs without any modifiers and prints out to the console
- The build should be security conscious
	- Starting on line 29 I copy the gaiad binaries to a distroless container. This container is the minimal components to run gaiad.
#### Summary
I spent a lot of time here trying to get the gaiad service to come up. I've never used this software but was reviewing the [docs](https://hub.cosmos.network/main/getting-started/what-is-gaia.html)  to get up and running. If I had more time I could get a better understanding on how it all works. I did my best to timebox the dockerfile task and get what I could completed.

# k8s FTW
Write a Kubernetes StatefulSet to run the above, using persistent volume claims and resource limits. [15 pts]

## Answer
The **gaia-stateful.yml** and **gaia-storage.yml** files create a statefulset and creates PVC's for the statefulset.

#### Summary
I've written this yml code many times and took the code from one of my deployments at home and formatted it to use the docker image built from the Dockerfile.

# All the observabilities
Alter the Gaia config file to enable prometheus metrics. Create a prometheus config or ServiceMonitor k8s resource to scrape the endpoint. [15 pts]

## Answer
I created the **config.toml** file to enable prometheus to scrape the gaia application on port 26657.

#### Summary
When researching how to do this, I first looked in the repo and didn't find anything related to prometheus. But when I did a word search through the code I found many matches in **go.mod** files. I have very little exposure to go but it looks like the **go.mod** is a dependency file like a packages.json file for nodejs. It seems like a prometheus instance is created along side of the gaia app. This was very interesting.  Being desperate from a lack of knowledge on go and lack of time, I thought "What if I just paste the question in ChatGPT?". The results were great, I'm not confident in the accuracy but I got a lot of great context from it. Essentially the feedback was, config.toml is likely a config file for go. Then it populated the body of the **config.toml** file.

## Script kiddies
Source or come up with a text manipulation problem and solve it with at least two of awk, sed, tr and / or grep. Check the question below first though, maybe.

## Answer
**Problem**: Replace the word "red" with "blue" in the string below.
"My favorite color is red!"
**Solution**:  `echo "My favorite color is red!" | sed 's/red/blue/g'`

#### Summary
Keeping things simple, I just used a sed command to search and replace "red" for "blue". 

## Script grown-ups
Solve the problem in question 4 using any programming language you like.

## Answer
**Problem**: Replace the word "red" with "blue" in the string below.
"My favorite color is red!"
**Solution**: `string = "My favorite color is red!"
new_string = string.replace("red", "blue")
print(new_string)`

#### Summary
Following the simplistic approach from above I used Python's string.replace method to replace "red" with "blue"

## Terraform lovers unite
write a Terraform module that creates the following resources in IAM; 
- A role, with no permissions, which can be assumed by users within the same account 
- A policy, allowing users / entities to assume the above role
- A group, with the above policy attached 
A user, belonging to the above group. All four entities should have the same name, or be similarly named in some meaningful way given the context e.g. prod-ci-role, prod-ci-policy, prod-ci-group, prod-ci-user; or just prod-ci. Make the suffixes toggleable, if you like.

## Answer
I created the **IAM.tf** file that consists of one variable to append suffices to the resources. One IAM role with no permissions, which can be assumed by users within the same account. One IAM policy allowing users / entities to assume the above role. One IAM group with the above policy attached. One IAM user belonging to the above group. All resources are named prod and can have a suffix appended to the names with the "name_suffix: variable.
#### Summary
This was pretty quick because of the avability of terraform registry. I was able to track down an [IAM example](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws/latest/examples/iam-policy). Then I was pointed to the source code found in the [terraform github repo](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/v5.10.0/examples/iam-policy).
