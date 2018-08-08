import React from 'react'

class PurchaseOrderPayType extends React.Component {
    render() {
        return (
            <div>
                <div className="field">
                    <label htmlFor="order_po_number">PO #</label>
                    <input type="text"
                           id="order_po_number"
                           name="order[po_number]" />
                </div>
            </div>
        )
    }
}

export default PurchaseOrderPayType