/* log_only_1017a78 @ 0x8db004, 52 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   FIND:: End of LISTEN phase.
 * Зовёт сам: __ld_r13_to_r13_ret, find_mng__search, fw_log_emit0, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global log_only_1017a78
log_only_1017a78:
	.global L_8db004
L_8db004:
	push_s blink
L_8db006:
	push_s r13
L_8db008:
	mov_s r13,r0
L_8db00a:
	mov_s r1,0x1017a78
L_8db010:
	bl.d L_8dcba8
L_8db014:
	mov_s r0,0x2c
L_8db016:
	mov_s r0,0x0
L_8db018:
	st_s r0,[r13,0x18]
L_8db01a:
	ld_s r0,[r13,0xc]
L_8db01c:
	breq_s r0,0,L_8db028
	.global L_8db01e
L_8db01e:
	bl.d L_8e4b8c
L_8db022:
	mov_s r0,r13
L_8db024:
	b L_8c025c
	.global L_8db028
L_8db028:
	mov_s r0,blink
L_8db02a:
	mov_s r1,0x1244
L_8db030:
	bl L_8c9b28
L_8db034:
	b_s L_8db01e
L_8db036:
	nop_s
