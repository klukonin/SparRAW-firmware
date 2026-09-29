/* SDP__hwd_sdp_is_int_ctrl_sdp @ 0x8d1510, 60 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   SDP::hwd_sdp_is_int_ctrl_sdp() the following port was not expected to be interrupt controled: %d
 *   hw_drivers_sdp.c
 * Зовут его: rgf_reg_880b80, sdp__init_int_ctrl
 * Зовёт сам: SDP__hwd_sdp_is_defined_sdp, __ld_r13_ret, fw_log__emit1, fw_sysassert_fatal
 */
	.section .text.SDP__hwd_sdp_is_int_ctrl_sdp,"ax",@progbits
	.global SDP__hwd_sdp_is_int_ctrl_sdp
SDP__hwd_sdp_is_int_ctrl_sdp:
	.global L_8d1510
L_8d1510:
	push_s blink
L_8d1512:
	push_s r13
L_8d1514:
	bl.d L_8d14a8
L_8d1518:
	mov_s r13,r0
L_8d151a:
	brlo r13,0xa,L_8d1522
L_8d151e:
	brlo r13,0x10,L_8d1548
	.global L_8d1522
L_8d1522:
	mov_s r2,0x1019c98
L_8d1528:
	mov_s r0,0x0
L_8d152a:
	mov_s r1,r0
L_8d152c:
	bl.d L_8edfcc
L_8d1530:
	mov_s r3,r13
L_8d1532:
	mov_s r0,blink
L_8d1534:
	mov_s r2,0x1019c84
L_8d153a:
	mov_s r1,0x1310
L_8d1540:
	bl.d L_8c82c0
L_8d1544:
	mov r3,0x133
	.global L_8d1548
L_8d1548:
	b L_8c033c
