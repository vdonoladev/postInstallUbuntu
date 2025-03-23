<h1 align="center" style="font-weight: bold;">PostInstallUbuntu</h1>

<p align="center">
  <a href="#tech">Tecnologias</a> • 
  <a href="#about">Sobre</a> •
  <a href="#started">Começando</a> • 
  <a href="#contribute">Contribuir</a>
</p>

<p align="center">
    <b>Script para configurar e otimizar o Ubuntu após a instalação.</b>
</p>

<h2 id="tech">Tecnologias</h2>

- [Bash Script](https://devdocs.io/bash)

<h2 id="about">Sobre</h2>

<p>Este script é destinado a automatizar a configuração e otimização do Ubuntu após a instalação. Ele inclui tarefas como atualização do sistema, instalação de pacotes essenciais, e ajustes de configuração.</p>

<h3>Funcionalidades</h3>

- Atualização do sistema
- Instalação de pacotes essenciais
- Configurações de desempenho
- Limpeza do sistema

<h2 id="started">Começando</h2>

1. **Clone este repositório:**

```bash
git clone https://github.com/vdonoladev/postInstallUbuntu.git
```

2. **Navegue até o diretório do projeto:**

```bash
cd postInstallUbuntu
```

3. **Torne o script executável:**

`chmod +x afterInstall.sh`
,
`chmod +x systemUpdate.sh`
e
`chmod +x postInstall.sh`

4. **Execute o arquivo:**

`sudo bash afterInstall.sh`
,
`sudo bash systemUpdate.sh`
e
`sudo bash postInstall.sh`

<h3>Pré-requisitos</h3>

- Distribuição Linux baseada em Ubuntu
- Permissão de administrador (sudo)
- Terminal com suporte a Bash

<h2 id="contribute">Contribuir</h2>

1. `git clone https://github.com/vdonoladev/postInstallUbuntu.git`
2. `git checkout -b feature/NAME-OF-FEATURE`
3. Siga os **Commit Patterns**
4. Abra um **Pull Request** explicando o problema resolvido ou o recurso feito, se houver, anexe a captura de tela das modificações visuais e aguarde a revisão!

<h3>Documentações que podem ajudar</h3>

- [📝 How to create a Pull Request](https://www.atlassian.com/br/git/tutorials/making-a-pull-request)

- [💾 Commit pattern](https://gist.github.com/joshbuchea/6f47e86d2510bce28f8e7f42ae84c716)
