import React from 'react'

class CreditCardPayType extends React.Component {
    render() {
        return(
            <div>
                <div className="field">
                    <label htmlFor="order_credit_card_number">CC #</label>
                    <input type="text"
                           name="order[credit_card_number]"
                           id="order_credit_card_number" />
                </div>
                <div className="field">
                    <label htmlFor="order_expiration_date">Expiration Date</label>
                    <input type="text"
                           name="order[expiration_date]"
                           size="9"
                           placeholder="eg. 03/19"
                           id="order_expiration_date"/>
                </div>
            </div>
        )
    }
}

export default CreditCardPayType