#### Requirements
 *  Ansible - `brew install ansible`

#### Create Vagrant VM
`
vagrant up
`

#### Create Gemfile.lock
`
docker run --rm -v /app:/usr/src/app -w /usr/src/app ruby:2.1.5 bundle install
`
