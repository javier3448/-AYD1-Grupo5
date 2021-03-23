let { app } = require('../index');
const { main } = require('../index');
let chai = require('chai');
let chaiHttp = require('chai-http');
const expect = require('chai').expect;
chai.use(chaiHttp);


describe('Testing API REST', function(){  

    describe('get main route: ',()=>{
        it('should get main route', (done) => {
        chai.request(app)
        .get('/')
        .end( function(err,res){
            if (err){
                console.log(err);
            } else {
                console.log(res.body)
                expect(res).to.have.status(200);
                done();
            }
        });
        });
    });
    
    describe('get all courses: ',()=>{
    it('should get all courses', (done) => {
    chai.request(app)
    .get('/getcourses')
    .end( function(err,res){
        if (err){
            console.log(err);
        } else {
            console.log(res.body)
            expect(res).to.have.status(202);
            done();
        }
    });
    });
    });

});