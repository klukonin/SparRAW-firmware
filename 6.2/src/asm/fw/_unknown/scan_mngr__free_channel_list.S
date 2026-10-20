/* scan_mngr__free_channel_list @ 0x8f3160, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   scan_mngr::free_channel_list() FREE SCAN Req for ch %d !!!
 * Зовут его: scan_mngr__abort_scan, scan_mngr__dwelling_done, scan_mngr__scan_done
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log_emit1, llist__pop_front, scan_mngr__free_with_842c74
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global scan_mngr__free_channel_list
scan_mngr__free_channel_list:
	.global L_8f3160
L_8f3160:
	push_s blink
L_8f3162:
	bl L_8c01e4
L_8f3166:
	mov_s r13,r0
L_8f3168:
	b_s L_8f3186
	.global L_8f316a
L_8f316a:
	bl L_8e2674
L_8f316e:
	mov_s r1,0x1015410
L_8f3174:
	mov_s r14,r0
L_8f3176:
	mov_s r0,0x2c
L_8f3178:
	bl.d L_8dcc10
L_8f317c:
	ld_s r2,[r14,0x8]
L_8f317e:
	mov_s r0,r13
L_8f3180:
	bl.d L_8f3154
L_8f3184:
	mov_s r1,r14
	.global L_8f3186
L_8f3186:
	add r0,r13,0x18
L_8f318a:
	ld_s r1,[r0]
L_8f318c:
	sub.f r1,r1,0x0
L_8f3190:
	mov.ne r1,0x1
L_8f3194:
	extb.f 0x0,r1
L_8f3198:
	bne_s L_8f316a
L_8f319a:
	b L_8c0254
L_8f319e:
	nop_s
