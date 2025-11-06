class mem_gen;
mem_tx tx,temp,tempq[$];
task run();
case(mem_common::test_name) 

"1WR":begin
mem_common::gen_count=1;
tx=new();
assert(tx.randomize() with {tx.wr_rd==1'b1;})
mem_common::gen2bfm.put(tx);
tx.print("mem_gen");
end

//---------------------------------------------------------------------

"5WR":begin
mem_common::gen_count=5;
repeat(5) begin
tx=new();
assert(tx.randomize() with {tx.wr_rd==1'b1;})
mem_common::gen2bfm.put(tx);
tx.print("mem_5WR_gen");
end
end

//---------------------------------------------------------------------

"1WR_1RD":begin
mem_common::gen_count=2;
tx=new();
assert(tx.randomize() with {tx.wr_rd==1'b1;})
mem_common::gen2bfm.put(tx);
tx.print("mem_1WR_gen");

temp=tx;    //deep copy(copy by handle)
tx=new();
assert(tx.randomize() with {tx.wr_rd==1'b0;tx.addr==temp.addr;tx.wdata==1'b0;})
mem_common::gen2bfm.put(tx);
tx.print("mem_1RD_gen");
end


//---------------------------------------------------------------------

"5WR_5RD":begin
mem_common::gen_count=10;
tx=new();
repeat(5) begin
assert(tx.randomize() with {tx.wr_rd==1'b1;})
temp=new tx;
mem_common::gen2bfm.put(temp);
tx.print("mem_5WR_gen");
////temp=tx;
tempq.push_back(temp);    //fifo behaviour
end
////
repeat(5) begin
temp=tempq.pop_front();
tx=new();
assert(tx.randomize() with {tx.wr_rd==1'b0;tx.addr==temp.addr;tx.wdata==1'b0;})
mem_common::gen2bfm.put(tx);
tx.print("mem_5RD_gen");
end
end

//---------------------------------------------------------------------

"NWR_NRD":begin
mem_common::gen_count=2*mem_common::N;
tx=new();
repeat(mem_common::N) begin

assert(tx.randomize() with {tx.wr_rd==1'b1;})
temp=new tx;
mem_common::gen2bfm.put(temp);
tx.print("mem_NWR_gen");
////temp=tx;
tempq.push_back(temp);        //fifo behaviour
end
////
repeat(mem_common::N) begin
temp=tempq.pop_front();
tx=new();
assert(tx.randomize() with {tx.wr_rd==1'b0;tx.addr==temp.addr;tx.wdata==1'b0;})
mem_common::gen2bfm.put(tx);
tx.print("mem_NRD_gen");
end
//
end
endcase
endtask

endclass
//

//----------------1WR----------------------------
//# KERNEL: ------mem_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=8
//# KERNEL: wdata=79
//# KERNEL: rdata=0
//-----------------------------------------------


//-----------------5WR----------------------------
//# KERNEL: ------mem_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=8
//# KERNEL: wdata=79
//# KERNEL: rdata=0
//# KERNEL: ------mem_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=22
//# KERNEL: wdata=244
//# KERNEL: rdata=0
//# KERNEL: ------mem_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=31
//# KERNEL: wdata=205
//# KERNEL: rdata=0
//# KERNEL: ------mem_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=6
//# KERNEL: wdata=63
//# KERNEL: rdata=0
//# KERNEL: ------mem_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=24
//# KERNEL: wdata=165
//# KERNEL: rdata=0
//-----------------------------------------


//------------------1WR_1RD------------------
//# KERNEL: ------mem_1WR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=8
//# KERNEL: wdata=79
//# KERNEL: rdata=0
//# KERNEL: ------mem_1RD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=8
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//---------------------------------------------


//---------------------5WR_5RD-----------------------
//# KERNEL: ------mem_5WR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=8
//# KERNEL: wdata=79
//# KERNEL: rdata=0
//# KERNEL: ------mem_5WR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=22
//# KERNEL: wdata=244
//# KERNEL: rdata=0
//# KERNEL: ------mem_5WR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=31
//# KERNEL: wdata=205
//# KERNEL: rdata=0
//# KERNEL: ------mem_5WR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=6
//# KERNEL: wdata=63
//# KERNEL: rdata=0
//# KERNEL: ------mem_5WR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=24
//# KERNEL: wdata=165
//# KERNEL: rdata=0
//# KERNEL: ------mem_5RD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=8
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_5RD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=22
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_5RD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=31
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_5RD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=6
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_5RD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=24
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//--------------------------------------------------------------------


//---------------------------NWR_NRD,N=6------------------------------
//# KERNEL: ------mem_NWR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=8
//# KERNEL: wdata=79
//# KERNEL: rdata=0
//# KERNEL: ------mem_NWR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=22
//# KERNEL: wdata=244
//# KERNEL: rdata=0
//# KERNEL: ------mem_NWR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=31
//# KERNEL: wdata=205
//# KERNEL: rdata=0
//# KERNEL: ------mem_NWR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=6
//# KERNEL: wdata=63
//# KERNEL: rdata=0
//# KERNEL: ------mem_NWR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=24
//# KERNEL: wdata=165
//# KERNEL: rdata=0
//# KERNEL: ------mem_NWR_gen--------
//# KERNEL: wr_rd=1
//# KERNEL: addr=6
//# KERNEL: wdata=226
//# KERNEL: rdata=0
//# KERNEL: ------mem_NRD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=8
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_NRD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=22
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_NRD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=31
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_NRD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=6
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_NRD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=24
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//# KERNEL: ------mem_NRD_gen--------
//# KERNEL: wr_rd=0
//# KERNEL: addr=6
//# KERNEL: wdata=0
//# KERNEL: rdata=0
//--------------------------------------------------------------
