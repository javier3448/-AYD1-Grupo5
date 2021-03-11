let chai = require('chai');
let chaiHttp = require('chai-http');
const expect = require('chai').expect;
chai.use(chaiHttp);
const url= 'http://13.58.126.153:4000/';


describe('get all courses: ',()=>{
    it('should get all courses', (done) => {
    chai.request(url)
    .get('/getcourses')
    .end( function(err,res){
    console.log(res.body)
    expect(res).to.have.status(200);
    done();
    });
    });
   });