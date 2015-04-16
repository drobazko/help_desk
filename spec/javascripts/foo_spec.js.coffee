#= require jquery
#= require chai-jquery

describe 'Foo', ->
  beforeEach ->
    ;
    
  it "jquery testing", ->
    expect($('<input type="checkbox" checked="checked"/>')).to.be.checked;