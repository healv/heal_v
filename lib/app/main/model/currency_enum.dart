enum CurrencyEnum {
  usd(currency: 'usd', symbol: '\$');

  final String currency;
  final String symbol;

  const CurrencyEnum({required this.currency, required this.symbol});

  static Map<String, CurrencyEnum> _map = {for (var item in CurrencyEnum.values) item.currency: item};

  static CurrencyEnum? from(String? currency) => _map[currency];
}
