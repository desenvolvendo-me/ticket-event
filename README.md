<p align="center">
  <img src="https://github.com/AngeloSouza1/tmp/blob/main/Ticket%20Event%20(1).gif" alt="Ticket Event (1)">

</p>

<p align="center">
  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/desenvolvendo-me/ticket-event?color=%2304D361">

  <img alt="Repository size" src="https://img.shields.io/github/repo-size/desenvolvendo-me/ticket-event">

  
  <a href="https://github.com/desenvolvendo-me/ticket-event/commits/main">
    <img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/desenvolvendo-me/ticket-event">
  </a>
    
   <img alt="License" src="https://img.shields.io/badge/license-MIT-brightgreen">
   <a href="https://github.com/desenvolvendo-me/ticket-event/stargazers">
    <img alt="Stargazers" src="https://img.shields.io/github/stars/desenvolvendo-me/ticket-event?style=social">
  </a>

  <a href="https://www.youtube.com/channel/UCp98bXHSc01w8fBfkkgHB1Q">
    <img alt="Feito pela Desenvolvendo Me" src="https://img.shields.io/badge/feito%20por-Desenvolvendo Me-%237519C1">
  </a>
  
  <a href="https://instagram.com/desenvolvendomecanal?igshid=YmMyMTA2M2Y=/">
    <img alt="Stargazers" src="https://img.shields.io/badge/Instagram-Desenvolvendo Me-%237159c1?style=flat&logo=ghost">
    </a>
  
 
</p>
<h1 align="center">
      Projeto Startup - Mentoria
</h1>

<h4 align="center"> 
	🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫 ticket-event 🚀 🎫🎫🎫🎫🎫🎫🎫🎫🎫🎫
</h4>

<p align="center">
 <a href="#-sobre-o-projeto">Sobre</a> •
 <a href="#-layout">Layout</a> • 
 <a href="#-como-executar-o-projeto">Como executar</a> • 
 <a href="#-tecnologias">Tecnologias</a> • 
</p>


## 💻 Sobre o projeto

<div align="justify">

🎫 **ticket-event** - apresento a você uma plataforma completa para criação e gerenciamento de eventos, abrangendo palestras, vídeos, oportunidades de cursos e envio de convites. A aplicação visa otimizar o processo de organização de eventos e oferecer uma experiência completa aos participantes.

Projeto desenvolvido durante o período da Mentoria oferecida pela [Desenvolvendo Me](https://instagram.com/desenvolvendomecanal?igshid=YmMyMTA2M2Y=/). É uma experiência online com muito conteúdo prático e desafios, onde o conteúdo disponível fica cada vez mais desafiador, visando desenvolver e evoluir seu conhecimento na prática com experiências reais.

</div>


---

## 🎨 Layout

Algumas funcionalidades:

<p align="center">
  <img alt="NextLevelWeek" title="#NextLevelWeek" src="https://github.com/AngeloSouza1/tmp/blob/main/tela1.png" width="400px">
  <img alt="NextLevelWeek" title="#NextLevelWeek" src="https://github.com/AngeloSouza1/tmp/blob/main/tela2.png" width="400px">
</p>


<p align="center" style="display: flex; align-items: flex-start; justify-content: center;">
  <img alt="NextLevelWeek" title="#NextLevelWeek" src="https://github.com/AngeloSouza1/tmp/blob/main/tela3.png" width="400px">
  <img alt="NextLevelWeek" title="#NextLevelWeek" src="https://github.com/AngeloSouza1/tmp/blob/main/tela4.png" width="400px">
</p>

---

## 🚀 Como executar o projeto

💡 Para execução deste projeto, siga os passos abaixo:

### Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
[Git](https://git-scm.com), um gerenciador de versões como o [ASDF](https://asdf-vm.com) e além disto é bom ter um editor para trabalhar com o código como [VSCode](https://code.visualstudio.com/)

#### 🎲 Rodando a aplicação

##### ➡️  Clone este repositório (branch: release/v0.1)
```bash
$ git clone git@github.com:desenvolvendo-me/ticket-event.git
```
##### ➡️   Gere o Banco de Dados Local e também rode as migracões da aplicação


<div align="justify">
	
#####    ⚠️   Algumas implementações estão em desenvolvimento e para funcionamento da aplicação  precisam ser desabilitadas, como esta migração:      [20231225224251_add_column_prize_to_prize_draws.rb]()


</div>

<p align="center">
    <img alt="NextLevelWeek" title="#NextLevelWeek" src="https://github.com/AngeloSouza1/tmp/blob/main/prize.png" width="500px">
</p>

##### ➡️  Iniciando a Aplicação com o framework Tailwind
```bash
$ foreman start -f Procfile.dev
```
##### ➡️ 👁️‍🗨️ Caso o comando acima, não funcione, seguir o procedimento abaixo:
```bash.
# --- execuções do arquivo Dockerfile ---

 rm -rf node_modules && npm install

 npm install esbuild

 bundle exec rake assets:precompile

 bundle exec rake assets:clean

 bundle exec rails tailwindcss:build 

```
##### ⚠️  Persistindo algum erro, seguir os procedimentos abaixo:

##### 🔹 Execute este comando para atualizar o Bundler
```bash
$  gem install bundler:2.4.20
```
##### 🔹 Execute este comando:
```bash
$  bundle exec rails tailwindcss:build
```
##### ➡️  Execute o comando para subir o servidor da aplicação:
```bash
$  bundle exec rails s    
```
---

## 🛠 Tecnologias

As seguintes ferramentas foram usadas na construção do projeto:
-   **Ruby - Versão: 2.7.5**










