pipeline {
  agent {
    node {
      label 'hyperv'
    }
    
  }
  stages {
    stage('get source') {
      steps {
        git(url: 'https://github.com/PatrickLang/packer-windows.git', branch: 'hyperv-insider-gen2', changelog: true)
      }
    }
    stage('packer build') {
      steps {
        sh 'packer.exe build --only=hyperv-iso windows_server_insider_docker.json'
      }
    }
  }
}