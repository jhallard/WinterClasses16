// Author : John Allard
// Date   : March 02 2016
// Assignment : CS112 HW #5 Dafny Programs

// 1. Implement a Min function in Dafny that returns the minimum of two integers and 
//    add appropiate post-condition(s).
method Min(a: int, b: int) returns (c: int)
  ensures a <= b ==> c == a
  ensures a > b ==> c == b
{
  if (a <= b) {
    c := a;
  } else {
    c := b;
  }
}
method TestMin()
{
  var m := Min(12,5);
  assert m == 5;
  var n := Min(23,42);
  assert n == 23; 
}
// The method TestMin() has assertions that will be enforced statically by the verifier. 
// Therefore, the program will not verify unless the post conditions of Min allows the assertions 
// in TestMin() to be statically verified.


// 2. The following Dafny method searches an array of integers for an element and returns 
//    the index of the first occurance of that element. If the array does not include the element, 
//    Search should return -1. Add pre-, post-conditions and loop invariants to make the code compile 
//    and to statically verify the assertions in the TestSearch method.

method Search(arr: array<int>, element: int) returns (idx: int)
{
  var n := 0;
  while (n < arr.Length)
  {
    if (arr[n] == element) {
      return n;
    }
    n := n + 1;
  }
  return -1;
}

method TestSearch()
{
  var arr := new int[3];
  arr[0] := 23;
  arr[1] := 21;
  arr[2] := 22;
  var s := Search(arr, 21);
  assert s == 1;
  var t := Search(arr, 20);
  assert t == -1;
}
