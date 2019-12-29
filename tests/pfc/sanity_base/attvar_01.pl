#!/usr/bin/env swipl

% Tests Emulation of assertable attributed variables
:- include(test_header).

:- ensure_loaded(library(attvar_reader)).

%:- pfc_test_feature(mt,must_not_be_pfc_file).

sk1:attr_unify_hook(_,_).

:- debug_logicmoo(_).
:- nodebug_logicmoo(http(_)).
:- debug_logicmoo(logicmoo(_)).

% :- dynamic(sk1_in/1).

:- read_attvars(true).
% :- set_prolog_flag(assert_attvars,true).

sk1_in(avar([vn='Ex'],[sk1='SKF-666'])).

:- listing(sk1_in/1).

:- must((sk1_in(Ex),get_attr(Ex,sk1,What),What=='SKF-666')).

