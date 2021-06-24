module TransactionsHelper

  def trx_kind(trx)
    if trx.kind == 'money_deposit' then
      ('<td>Depósito</td>').html_safe
    elsif trx.kind == 'outgoing_money' then
      ('<td>Saque</td>').html_safe
    elsif trx.kind == 'transfer' then
      ('<td>Transferência</td>').html_safe
    end
  end
end
