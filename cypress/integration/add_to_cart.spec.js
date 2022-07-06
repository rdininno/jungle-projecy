describe('Add to Cart', () => {
  it("Add to cart button adds one to cart", () => {
    cy.visit('http://localhost:3000')
    cy.get(".btn").contains('Add')
      .first()
      .click({force: true});

      cy.get(".end-0").should("contain", "1");
  })  
})