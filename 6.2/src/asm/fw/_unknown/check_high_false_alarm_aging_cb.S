/* check_high_false_alarm_aging_cb @ 0x8f1980, 56 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   check_high_false_alarm_aging_cb g_high_false_alarm_cnt=%d prev_cnt=%d
 * Зовёт сам: __ld_r13_to_r13_ret, fw_log_emit2, fw_sysassert_fatal
 * Глобалы (через gp): 0x800370
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global check_high_false_alarm_aging_cb
check_high_false_alarm_aging_cb:
	.global L_8f1980
L_8f1980:
	push_s blink
L_8f1982:
	push_s r13
L_8f1984:
	mov_s r13,r0
L_8f1986:
	ld.as r2,[gp,0x7b]
L_8f198a:
	mov_s r1,0x100f4e8
L_8f1990:
	mov_s r0,0x2b
L_8f1992:
	bl.d L_8dcc80
L_8f1996:
	mov_s r3,r13
L_8f1998:
	ld_s r0,[gp,0x1ec]
L_8f199a:
	sub_s r0,r0,r13
L_8f199c:
	cmp_s r0,0x8
L_8f199e:
	mov.cc r0,blink
L_8f19a2:
	mov.cc r1,0x142e
L_8f19aa:
	bl.cc L_8c9b28
L_8f19ae:
	mov_s r0,0x0
L_8f19b0:
	b.d L_8c025c
L_8f19b4:
	st.as r0,[gp,-0x2a]
