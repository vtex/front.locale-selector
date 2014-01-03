window.vtex = window.vtex || {}
window.vtex.i18n = window.vtex.i18n || {}

class VtexI18n
	constructor: ->
		@locale = $('html').attr('lang') or $('meta[name="language"]').attr('content') or 'pt-BR'
		@countryCode = $('meta[name="country"]').attr('content') or 'BRA'
		@currency = $('meta[name="currency"]').attr('content')
		# Default by country code
		@currency or= switch @countryCode
			when 'BRA' then 'R$'
			when 'URY' then '$U'
			when 'PRY' then 'Gs'
			when 'PER' then 'S/.'
			when 'VEN' then 'Bs. F.'
			else '$'

	getLocale: => return @locale

	setLocale: (localeParam) =>
		@locale = localeParam
		if window.i18n
			window.i18n.setLng(@locale)
			$('html').i18n()
			$("#vtex-locale-select").select2("val", @locale) if $("#vtex-locale-select")[0]
		@callLocaleCallback(@locale)

	setLocaleCallback: (callback) =>
		@localeCallback = callback

	getCountryCode: => return @countryCode

	setCountryCode: (countryCodeParam) =>
		@countryCode = countryCodeParam
		@callCountryCodeCallback(@countryCode)

	setCountryCodeCallback: (callback) =>
		@countryCodeCallback = callback

	getCurrency: => return @currency + ' '

	setCurrency: (currency) =>
		@currency = currency

	getDecimalSeparator: (countryCodeParam) =>
		countryCode = if countryCodeParam then countryCodeParam else window.vtex.i18n.getCountryCode()
		switch countryCode
			when 'USA'
				return '.'
			when 'URY'
				return '.'
			else
				return ','

	getThousandsSeparator: (countryCodeParam) =>
		countryCode = if countryCodeParam then countryCodeParam else window.vtex.i18n.getCountryCode()
		switch countryCode
			when 'USA'
				return ','
			else
				return '.'

	translateHtml: (selector = 'html') =>
		$(selector).i18n?() if window.i18n

	###
	# Caso o callback seja do tipo function, chama a função
	# Caso seja do tipo string assume-se que será chamado um canal do Radio
	###
	callLocaleCallback: (val) =>
		if typeof(@localeCallback) is 'function'
			@localeCallback(val)
		else if (typeof(@localeCallback) is 'string' and window.radio)
			radio(@localeCallback).broadcast(val)

	callCountryCodeCallback: (val) =>
		if typeof(@countryCodeCallback) is 'function'
			@countryCodeCallback(val)
		else if (typeof(@countryCodeCallback) is 'string' and window.radio)
			radio(@countryCodeCallback).broadcast(val)

$.extend(window.vtex.i18n, new VtexI18n())

# Compatibilidade com versões antigas
window.vtex.VtexI18n = VtexI18n
window.vtex.i18n.getCurrencySymbol = window.vtex.i18n.getCurrency