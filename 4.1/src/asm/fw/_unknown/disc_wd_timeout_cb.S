/* disc_wd_timeout_cb @ 0x8eb164, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   disc_wd_timeout_cb()- Timer Expired
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit0, wait_for_disconnect
 */
	.section .text.disc_wd_timeout_cb,"ax",@progbits
	.global disc_wd_timeout_cb
disc_wd_timeout_cb:
	.byte 0x8f
	.byte 0xea
	.global fwlog_disc_wd_timeout_cb_Timer_Expired
fwlog_disc_wd_timeout_cb_Timer_Expired:
L_8eb166:
	nop_s
L_8eb168:
	push_s blink
L_8eb16a:
	bl.d L_8c02c4
L_8eb16e:
	mov_s r1,0x1
L_8eb170:
	mov_s r13,r0
L_8eb172:
	mov_s r14,0x0
L_8eb174:
	st_s r14,[r0,0x40]
L_8eb176:
	mov_s r2,0x100fa98
L_8eb17c:
	bl.d L_8edfb0
L_8eb180:
	mov_s r0,0xb
L_8eb182:
	st_s r14,[r13,0x3c]
L_8eb184:
	bl.d L_8f2acc
L_8eb188:
	mov_s r0,r13
L_8eb18a:
	.byte 0xad,0x01
