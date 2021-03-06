# front.i18n

O seletor front end de línguas.

Existem dois scripts no plugin: **vtex-i18n.js** e **vtex-locale-selector.js**. Sendo o segundo dependente do primeiro.

O **vtex-i18n.js** é responsável pelo locale, countryCode e currency do site. Enquanto o **vtex-locale-selector.js** cuida do plugin i18next.

Diferente do **vtex-locale-selector.js**, o **vtex-i18n.js** é iniciado automaticamente, não necessitando de nenhuma instanciação ou script extra.

O locale tem seu default definido na seguinte ordem de ocorrência:

```html
    <!-- Atributo lang da tag html -->
    <html lang="en-US">
    
    <!-- Tag meta com language -->
    <meta name="language" content="en-US"/>
    
    <!-- Fallback para pt-BR -->
```

O countryCode irá setar como default :

```html
    <!-- Tag meta com country -->
    <meta name="country" content="USA"/>
    
    <!-- Fallback para BRA -->
```

## vtex-i18n.js

Dependência: [jQuery](http://jquery.com/).

<h4 id="setLocale"><code>vtex.i18n.setLocale(locale)</code></h4>
<p>Troca a língua corrente.</p>
<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<th style="width: 90px;">Param</th>
			<th style="width: 50px;">tipo</th>
			<th style="width: 140px;">exemplo</th>
			<th>descrição</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>locale</td>
			<td>string</td>
			<td><code>"en-US"</code></td>
			<td>Locale da língua a ser usada.</td>
		</tr>
	</tbody>
</table>

<br>

<h4 id="getLocale"><code>vtex.i18n.getLocale()</code></h4>
<p>Retorna o locale corrente.</p>

<br>

<h4 id="setLocaleCallback"><code>vtex.i18n.setLocaleCallback(callback)</code></h4>
<p>Seta uma função de callback ao trocar a língua.</p>
<table class="table table-bordered table-striped">
    <thead>
    	<tr>
			<th style="width: 90px;">Param</th>
			<th style="width: 50px;">tipo</th>
			<th style="width: 140px;">exemplo</th>
			<th>descrição</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>callback</td>
			<td>function ou string</td>
			<td>função ou <code>"vtex.i18n.update"</code></td>
			<td>Caso seja do tipo <code>function</code>, o callback chamará a função passando como parametro o novo locale. Caso seja do tipo <code>string</code>, assume-se que será chamado um canal do Radio.<br> Ex: para o parametro do tipo string <code>vtex.i18n.update</code>, um possível callback a ser chamado seria: <code>radio('vtex.i18n.update').broadcast('pt-BR')</code></td>
		</tr>
	</tbody>
</table>

<br>

<h4 id="setCountryCode"><code>vtex.i18n.setCountryCode(countryCode)</code></h4>
<p>Troca o countryCode a ser usado pela função <code>vtex.i18n.getCurrencySymbol</code></p>
<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<th style="width: 90px;">Param</th>
			<th style="width: 50px;">tipo</th>
			<th style="width: 140px;">exemplo</th>
			<th>descrição</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>countryCode</td>
			<td>string</td>
			<td><code>"USA"</code></td>
			<td><code>countryCode</code> do país.</td>
		</tr>
	</tbody>
</table>

<br>

<h4 id="getCountryCode"><code>vtex.i18n.getCountryCode()</code></h4>
<p>Retorna o countryCode corrente.</p>

<br>


<h4 id="setCountryCodeCallback"><code>vtex.i18n.setCountryCodeCallback(callback)</code></h4>
<p>Seta uma função de callback ao trocar o <code>countryCode</code>.</p>
<table class="table table-bordered table-striped">
    <thead>
		<tr>
			<th style="width: 90px;">Param</th>
			<th style="width: 50px;">tipo</th>
			<th style="width: 140px;">exemplo</th>
			<th>descrição</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>callback</td>
			<td>function ou string</td>
			<td>função ou <code>"vtex.countryCode.update"</code></td>
			<td>Caso seja do tipo <code>function</code>, o callback chamará a função passando como parametro o novo <code>countryCode</code>. Caso seja do tipo <code>string</code>, assume-se que será chamado um canal do Radio.<br> Ex: para o parametro do tipo string <code>vtex.countryCode.update</code>, um possível callback a ser chamado seria: <code>radio('vtex.countryCode.update').broadcast('ARG')</code></td>
		</tr>
	</tbody>
</table>

<br>

<h4 id="getCurrencySymbol"><code>vtex.i18n.getCurrency(countryCode)</code></h4>
<p>Retorna o símbolo monetário do país.</p>
<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<th style="width: 90px;">Param</th>
			<th style="width: 50px;">tipo</th>
			<th style="width: 140px;">exemplo</th>
			<th>descrição</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>countryCode</td>
			<td>string</td>
			<td><code>"ARG"</code> (opcional)</td>
			<td>Tem como default o valor de <code>vtex.i18n.getCountryCode</code> ou pelo <code>countryCode</code> passado como parametro.</td>
		</tr>
	</tbody>
</table>

## vtex-locale-selector.js

Dependências: vtex-i18n.js, [jQuery](http://jquery.com/), [Select2](http://ivaynberg.github.io/select2/), [i18next](http://i18next.com/).

Primeiramente carregue todas as dependências. Em seguida, carregue seus arquivos de translations. Você pode encontrar um exemplo do formato a ser seguido em `/src/coffee/translation-en-US.coffee`.

Agora é só inicar o plugin no evento de `$(document).ready()` do jQuery com a função `vtex.i18n.init()`.

Para traduzir um elemento na página, adicione o atributo `data-i18n` com o valor da chave do arquivo de translation. Por exemplo:

```html
<p data-i18n="chave"></p>
```
    
Caso queira traduzir um atributo do elemento HTML, como o atributo `title`, `alt` ou `placeholder`. Use o seguinte formato:

```html
<a data-i18n="[title]chave"></a>
```

Caso não queira ter um select para o usuário final trocar de língua, apenas não inclua o elemento com o id `#vtex-locale-selector`, tudo continuará a funcionar normalmente. Ou seja, você ainda poderá usar a API por Javascript.


<h4 id="init"><code>vtex.i18n.init()</code></h4>
<p>Inicia o plugin.</p>

Podendo ser extensível com a biblioteca de pub/sub [Radio.js](http://radio.uxder.com/).

-------

VTEX - 2013
