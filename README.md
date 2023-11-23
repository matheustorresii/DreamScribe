<div align="center">
  <h1>DreamScribe</h1>
</div>

<div align="center">
  <img width=300px height=300px src="https://github.com/matheustorresii/DreamScribe/blob/master/DreamScribe/Assets.xcassets/AppIcon.appiconset/1024.png?raw=true"/>
</div>

<h3>
  DreamScribe é o seu diário de sonhos! Conecte-se com seu eu interior e registre a memória dos seus sonhos nesse diário. Analise seu lado onírico e receba insights sobre o seu subconsciente
</h3>

<h4>
  <i> "O espelho e os sonhos são coisas semelhantes, é como a imagem do homem diante de si próprio." <br> - José Saramago </i>
</h4>

<hr>

<h3>
  Instruções para rodar o projeto:
</h3>
- É necessário o ambiente para desenvolvimento instalado com o XCode (iOS mínimo: 16.4), e utilizamos o SPM (Swift Package Manager) para a instalação de 1 pacote de terceiros, no caso o <a href="https://lottiefiles.com/">Lottie</a> para nossas animações de Loading no app.
<br>
- O Backend feito em Java pode ser encontrado no repositório <a href="https://github.com/matheustorresii/DreamScribeApi">DreamScribeApi</a>
<br>
- Existe também um repositório de mock que foi usado para testar criado em Elixir, o <a href="https://github.com/matheustorresii/towers">towers</a>
<br>

<h3>
  Atenção:
</h3>
- Possuímos um <a href="https://github.com/matheustorresii/DreamScribe/blob/master/DreamScribe/Source/Utils/Env.swift">Arquivo de Ambiente</a> que possui uma variável que pode ser mudada de acordo com o ambiente utilizado (Escolher somente 1):

```swift
var ENV: Environment = .local
var ENV: Environment = .mock
var ENV: Environment = .api
```

<br>
- Caso deixe o valor como local, o app funcionará offline, utilizando de seu armazenamento interno para o funcionamento.
<br>
- Caso deixe o valor como mock, o app funcionará a partir do <a href="https://github.com/matheustorresii/towers">mock</a> citado anteriormente, utilizando de uma porta diferente para o funcionamento
<br>
- Por fim, caso o valor seja api, o app funcionará a partir da <a href="https://github.com/matheustorresii/DreamScribeApi">api</a> citada anteriormente, utilizando de uma porta diferente para o funcionamento
