/* uc__set_evt_id_5c @ 0x921724, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: bi__latch_tsf_and_reset, l1_task__report_link_lost, ucode_cmd_0x01_handler
 * Глобалы (через gp): 0x800584
 */
	.section .text.uc_code,"ax",@progbits
	.p2align 2
	.global uc__set_evt_id_5c
uc__set_evt_id_5c:
	.global L_921724
L_921724:
	lr r1,[0xa]
L_921728:
	bclr r2,r1,0x1
L_92172c:
	flag r2
L_921730:
	cmp_s r0,0x0
L_921732:
	mov_s r0,0x39
L_921734:
	mov.eq r0,0xffffffff
L_92173c:
	st.as r0,[gp,0x17]
L_921740:
	lr r0,[0xa]
L_921744:
	bic r1,r1,-0x3
L_921748:
	or_s r1,r1,r0
L_92174a:
	flag r1
L_92174e:
	j_s [blink]
