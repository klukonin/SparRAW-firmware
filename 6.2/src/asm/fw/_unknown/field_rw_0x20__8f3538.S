/* field_rw_0x20__8f3538 @ 0x8f3538, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysapi_mgr__send_evt2host, fw_sysapi_mgr__stop_sysapi_cmd
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global field_rw_0x20__8f3538
field_rw_0x20__8f3538:
	.global L_8f3538
L_8f3538:
	push_s blink
L_8f353a:
	push_s r13
L_8f353c:
	mov_s r13,r0
L_8f353e:
	mov_s r2,r1
L_8f3540:
	ld_s r1,[r0,0x20]
L_8f3542:
	add r4,r0,0x4
L_8f3546:
	bl.d L_8f8948
L_8f354a:
	mov_s r3,0xe
L_8f354c:
	mov_s r0,r13
L_8f354e:
	bl.d L_8f9bd0
L_8f3552:
	mov_s r1,0x7
L_8f3554:
	b L_8c025c
L_8f3558:
	st_s r1,[r0,0x20]
L_8f355a:
	b.d L_8f3538
L_8f355e:
	mov_s r1,r2
