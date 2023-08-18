let chai = require("chai");

let chaiHttp = require("chai-http");

let server = require("../server");

// assertion style

chai.should();

chai.use(chaiHttp);

describe("Cybershop User API TEST", () => {
  // test the login route

  describe("POST /api/login", () => {
    it("It should login a user", (done) => {
      chai

        .request(server)

        .post("/api/v2/login")

        .send({
          email: "adsasdasdsad@gmail.com",

          password: "dasd",
        })

        .end((err, res) => {
          res.should.have.status(201);

          done();
        });
    });
  });
});

describe("Cybershop User API TEST", () => {
  // test the logout route

  describe("GET /api/logout", () => {
    it("It should logout a user", (done) => {
      chai

        .request(server)

        .get("/api/v2/logout")

        .end((err, res) => {
          res.should.have.status(200);

          done();
        });
    });
  });
});

describe("Cybershop User API TEST", () => {
  // test the userdetails route

  describe("GET /api/userdetails", () => {
    it("It should get a user details", (done) => {
      chai

        .request(server)

        .get("/api/v2/me")

        .end((err, res) => {
          res.should.have.status(401);

          done();
        });
    });
  });
});

describe("Cybershop User API TEST", () => {
  // test the updatePassword route

  describe("PUT /api/updatePassword", () => {
    it("It should update a user password", (done) => {
      chai

        .request(server)

        .put("/api/v2/me/update")

        .send({
          password: "daadas",

          newPassword: "dasdads",

          passwordConfirm: "asdasd",
        })

        .end((err, res) => {
          res.should.have.status(401);

          done();
        });
    });
  });
});




describe("Cybershop User API TEST", () => {
  // test the delete route

  describe("GET /api/user deleted", () => {
    it("It should get a user deleted", (done) => {
      chai

        .request(server)

        .delete("/api/v2/admin/user/:id")

        .end((err, res) => {
          res.should.have.status(401);

          done();
        });
    });
  });
});

