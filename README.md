# Poke-Me : Lightweight build server

Poke-me is a lightweight build and deployment server. I am using this for my personal and small projects. 

I built this project to support my small infra bill. I do not want to spend a lot on my infrastructure as the project is still in it naive stage. 
I am using the free tier from Google Cloud Platform. Hence, minimising the infrastructure is the goal.

# How it works?
- Works similar to Jenkins, or any other build tool. It listens to pushes to the repository, on particular branches (regex support coming up).
- The project is expected to have a folder - `deploy` in the root of the project with files - `start.sh` and `stop.sh`. 
- Poke-me downloads your code base to a temporary folder -> (TODO: performs the build) -> stops the existing application -> copies new code to the location -> starts the application.

# Integrations
- [x] Gitlab
- [ ] Bitbucket
- [ ] Github