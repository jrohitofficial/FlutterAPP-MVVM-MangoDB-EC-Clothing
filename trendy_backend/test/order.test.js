let chai = require("chai");

let chaiHttp = require("chai-http");

let server = require("../server");

// assertion style

chai.should();

chai.use(chaiHttp);

describe("Cybershop User API TEST", () => {
  // test the order route

  describe("POST /api/orders", () => {
    it("It should get orders", (done) => {
      chai

        .request(server)

        .get("/api/v2//orders/me")

        .end((err, res) => {
          res.should.have.status(401);

          done();
        });
    });
  });
});




describe("Cybershop User API TEST", () => {
  // test the order route

  describe("POST /api/order", () => {
    it("It should create order details", (done) => {
      chai

        .request(server)

        .post("/api/v2/order/new")

        .send({
            shippingInfo: { 
                firstName: "tttt",
                lastName: "ttttt",
                address: "123 Main St",
                city: "New York",
                state: "NY",
                zip: "10001",
                country: "USA",
                phone: "1234567890"
            },   
          orderItems: [ { productId: 1, quantity: 1 } ],
            paymentInfo: { 
                cardNumber: "1234567890123456",
                cardExpiration: "12/20",
                cardCvv: "123"
            },
          itemsPrice:2000,
          taxPrice: 400,
          shippingPrice: 200,
          totalPrice: 4000
        })

        .end((err, res) => {
          res.should.have.status(401);

          done();
        });
    });
  });
});