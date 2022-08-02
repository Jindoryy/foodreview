package domain;

import org.junit.Test;

import static org.junit.Assert.*;

public class PageHandlerTest {

    @Test
    public void test() {
        PageHandler pageHandler = new PageHandler(250, 1);
        pageHandler.print();
        assertTrue(pageHandler.getBeginPage() == 1);
        assertTrue(pageHandler.getEndPage() == 10);
    }

    @Test
    public void test2() {
        PageHandler pageHandler = new PageHandler(250, 16);
        pageHandler.print();
        assertTrue(pageHandler.getBeginPage() == 11);
        assertTrue(pageHandler.getEndPage() == 20);
    }

    @Test
    public void test3() {
        PageHandler pageHandler = new PageHandler(255, 24);
        pageHandler.print();
        assertTrue(pageHandler.getBeginPage() == 21);
        assertTrue(pageHandler.getEndPage() == 26);
    }

    @Test
    public void test4() {
        PageHandler pageHandler = new PageHandler(255, 10);
        pageHandler.print();
        assertTrue(pageHandler.getBeginPage() == 11);
        assertTrue(pageHandler.getEndPage() == 20);
    }
}