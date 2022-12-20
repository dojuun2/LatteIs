package com.academy.latteis.quiz.repository;

import com.academy.latteis.common.page.DiaryPage;
import com.academy.latteis.quiz.domain.Quiz;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface QuizMapper {

    // 퀴즈 작성
    boolean write(Quiz quiz);

    // 퀴즈 리스트
    List <Quiz> findAll(DiaryPage diaryPage);

    // 퀴즈 총 개수
    int getTotalCount();

    // 퀴즈 삭제
    boolean delete(Long quizNo);

    // 퀴즈 하나
    Quiz findOne(Long quizNo);

    int answerCheck(String quizAnswer);

    void correctAnswer(int quizNo);

    void correctUser(String userNickname, int quizNo);
}
