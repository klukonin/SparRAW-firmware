/* maintain_sm__release_radio_after_bf_evt @ 0x8de158, 68 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   maintain_sm::release_radio_after_bf_evt()  remove_request 0x%x
 *   maintain_sm::release_radio_after_bf_evt()  unlocking radio 0x%x
 * Зовут его: bf__fail_retrying, maintain_sm__on_bf_results, maintain_sm__on_stop
 * Зовёт сам: RADIO_MGR__remove_request, RADIO_MGR__unlock, __ld_r14_to_r13_ret, __st_r14_to_r13, fw_log__emit1
 */
	.section .text.maintain_sm__release_radio_after_bf_evt,"ax",@progbits
	.global maintain_sm__release_radio_after_bf_evt
maintain_sm__release_radio_after_bf_evt:
	.global L_8de158
L_8de158:
	push_s blink
L_8de15a:
	bl L_8c02c4
L_8de15e:
	ld_s r3,[r0,0x48]
L_8de160:
	mov_s r14,r0
L_8de162:
	breq_s r3,0,L_8de198
L_8de164:
	ld_s r0,[r14,0x4c]
L_8de166:
	mov_s r13,0x0
L_8de168:
	brne_s r0,0,L_8de180
L_8de16a:
	mov_s r2,0x1011de8
L_8de170:
	mov_s r0,r13
L_8de172:
	bl.d L_8edfcc
L_8de176:
	mov_s r1,0x2
L_8de178:
	bl.d L_8de444
L_8de17c:
	ld_s r0,[r14,0x48]
L_8de17e:
	b_s L_8de194
	.global L_8de180
L_8de180:
	mov_s r2,0x1011e28
L_8de186:
	mov_s r0,r13
L_8de188:
	bl.d L_8edfcc
L_8de18c:
	mov_s r1,0x2
L_8de18e:
	bl.d L_8e54d8
L_8de192:
	ld_s r0,[r14,0x48]
	.global L_8de194
L_8de194:
	st_s r13,[r14,0x48]
L_8de196:
	st_s r13,[r14,0x4c]
	.global L_8de198
L_8de198:
	b L_8c0334
