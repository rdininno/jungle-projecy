describe('The Home Page', () => {
  it('successfully loads', () => {
    cy.visit('http://localhost:3000') // change URL to match your dev URL
  })

  it("Product page will load when product clicked on main page", () => {
    cy.visit('http://localhost:3000')
    cy.get(".products article")
      .first()
      .click();
    cy.get(".products-show .product-detail").should('be.visible');
  })  
})
