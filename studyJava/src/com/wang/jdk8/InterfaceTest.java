package com.wang.jdk8;

/**
 * Created by wang on 2016/10/11.
 */
public interface InterfaceTest {
    void add();
    void delete();
}
interface Sub extends InterfaceTest{
    void remove();
}

class Test implements Sub{

    @Override
    public void add() {

    }

    @Override
    public void delete() {

    }

    @Override
    public void remove() {

    }
}
