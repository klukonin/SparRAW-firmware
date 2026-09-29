/* wait_for_disconnect @ 0x8f2acc, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   wait_for_disconnect()- disassoc wasn't sent, continue to flush_connection()
 *   wait_for_disconnect()- disassoc frame was sent, wait for callback
 *   wait_for_disconnect()- callback already set, wait for callback
 * Зовут его: disc_wd_timeout_cb
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event, fw_log__emit0, u_schd__schedule
 */
	.section .text.wait_for_disconnect,"ax",@progbits
	.global wait_for_disconnect
wait_for_disconnect:
	.global L_8f2acc
L_8f2acc:
	push_s blink
L_8f2ace:
	push_s r13
L_8f2ad0:
	mov_s r13,r0
L_8f2ad2:
	ld_s r0,[r0,0x3c]
L_8f2ad4:
	brne_s r0,0,L_8f2af4
L_8f2ad6:
	mov_s r2,0x100f9c8
L_8f2adc:
	mov_s r0,0xb
L_8f2ade:
	bl.d L_8edfb0
L_8f2ae2:
	mov_s r1,0x2
L_8f2ae4:
	mov_s r0,r13
L_8f2ae6:
	mov_s r1,0x6
L_8f2ae8:
	mov_s r2,0x0
L_8f2aea:
	mov_s r3,r2
L_8f2aec:
	bl.d L_8d6a1c
L_8f2af0:
	mov_s r4,r2
L_8f2af2:
	b_s L_8f2b34
	.global L_8f2af4
L_8f2af4:
	ld_s r0,[r13,0x40]
L_8f2af6:
	brne_s r0,0,L_8f2b26
L_8f2af8:
	mov_s r2,0x100fa14
L_8f2afe:
	mov_s r0,0xb
L_8f2b00:
	bl.d L_8edfb0
L_8f2b04:
	mov_s r1,0x2
L_8f2b06:
	mov_s r0,0x2b168
L_8f2b0c:
	mov_s r1,r13
L_8f2b0e:
	mov_s r2,0x0
L_8f2b10:
	mov_s r3,0x2
L_8f2b12:
	mov r4,0xf4240
L_8f2b1a:
	mov_s r5,r2
L_8f2b1c:
	bl.d L_8dc92c
L_8f2b20:
	mov_s r6,r2
L_8f2b22:
	st_s r0,[r13,0x40]
L_8f2b24:
	b_s L_8f2b34
	.global L_8f2b26
L_8f2b26:
	mov_s r2,0x100fa58
L_8f2b2c:
	mov_s r0,0xb
L_8f2b2e:
	bl.d L_8edfb0
L_8f2b32:
	mov_s r1,0x2
	.global L_8f2b34
L_8f2b34:
	b L_8c033c
