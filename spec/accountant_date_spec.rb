require 'accountant_date'
require 'time'

describe "Date.parse" do
  it "should use accountant date format for mm/yy" do
    Date.parse('02/03', true).should == Date.new(2003, 2, 1)
  end

  it "should use accountant date format for m/yy" do
    Date.parse('2/03', true).should == Date.new(2003, 2, 1)
  end

  it "should use accountant date format for mmyy" do
    Date.parse('0203', true).should == Date.new(2003, 2, 1)
  end

  it "should use accountant date format for myy" do
    Date.parse('203', true).should == Date.new(2003, 2, 1)
  end

  it "should use accountant date format for mmddyyyy" do
    Date.parse('01152012', true).should == Date.new(2012, 1, 15)
  end

  it "should use accountant date format for mmddyy" do
    Date.parse('020503', true).should == Date.new(2003, 2, 5)
  end

  it "should use accountant date format for mddyy" do
    Date.parse('20503', true).should == Date.new(2003, 2, 5)
  end

  it "should ignore preceding whitespace" do
    Date.parse('  02/2003').should == Date.new(2003, 2, 1)
  end

  it "should still process regularly formatted dates" do
    Date.parse('1900-1-1', true).should == Date.new(1900, 1, 1)
  end

  it "should still process regularly formatted dates" do
    Date.parse('1/1/1900', true).should == Date.new(1900, 1, 1)
  end
end

describe "DateTime.parse" do
  it "should use accountant date format for mm/yy" do
    DateTime.parse('02/03', true).should == DateTime.new(2003, 2, 1)
  end

  it "should use accountant date format for m/yy" do
    DateTime.parse('2/03', true).should == DateTime.new(2003, 2, 1)
  end

  it "should use accountant date format for mmyy" do
    DateTime.parse('0203', true).should == DateTime.new(2003, 2, 1)
  end

  it "should use accountant date format for myy" do
    DateTime.parse('203', true).should == DateTime.new(2003, 2, 1)
  end

  it "should use accountant date format for ddmmyy" do
    DateTime.parse('020503', true).should == DateTime.new(2003, 2, 5)
  end

  it "should use accountant date format for dmmyy" do
    DateTime.parse('020503', true).should == DateTime.new(2003, 2, 5)
  end

  specify "should ignore preceding whitespace" do
    DateTime.parse('  02/2003').should == DateTime.new(2003, 2, 1)
  end
end

describe "Time.parse" do
  it "should use accountant date format for mm/yy" do
    Time.parse('02/03', true).should == Time.local(2003, 2, 1)
  end

  it "should use accountant date format for m/yy" do
    Time.parse('2/03', true).should == Time.local(2003, 2, 1)
  end

  it "should use accountant date format for mmyy" do
    Time.parse('0203', true).should == Time.local(2003, 2, 1)
  end

  it "should use accountant date format for myy" do
    Time.parse('203', true).should == Time.local(2003, 2, 1)
  end

  it "should use accountant date format for ddmmyy" do
    Time.parse('020503', true).should == Time.local(2003, 2, 5)
  end

  it "should use accountant date format for dmmyy" do
    Time.parse('020503', true).should == Time.local(2003, 2, 5)
  end

  it "should ignore preceding whitespace" do
    Time.parse('  02/2003').should == Time.local(2003, 2, 1)
  end

  it "should work with times" do
    Time.parse('02/2003 10:20:30').should == Time.local(2003, 2, 1, 10, 20, 30)
  end
end

describe "Date._parse" do
  specify "should use accountant date format for dd/mm/yy" do
    Date._parse('02/03', true).should == {:year=>2003, :mon=>2, :mday=>1}
  end

  it "should use accountant date format for m/yy" do
    Date._parse('2/03', true).should == {:year=>2003, :mon=>2, :mday=>1}
  end

  it "should use accountant date format for mmyy" do
    Date._parse('0203', true).should == {:year=>2003, :mon=>2, :mday=>1}
  end

  it "should use accountant date format for myy" do
    Date._parse('203', true).should == {:year=>2003, :mon=>2, :mday=>1}
  end

  it "should use accountant date format for ddmmyy" do
    Date._parse('020503', true).should == {:year=>2003, :mon=>2, :mday=>5}
  end

  it "should use accountant date format for dmmyy" do
    Date._parse('020503', true).should == {:year=>2003, :mon=>2, :mday=>5}
  end

  specify "should ignore preceding whitespace" do
    Date._parse('  02/2003').should == {:year=>2003, :mon=>2, :mday=>1}
  end

  specify "should work with times" do
    DateTime._parse('02/2003 10:20:30').should ==
      {:year=>2003, :mon=>2, :mday=>1, :hour=>10, :min=>20, :sec=>30}
  end
end
