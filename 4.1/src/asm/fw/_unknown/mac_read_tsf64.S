/* mac_read_tsf64 @ 0x8e4840, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ba_setup_sm__addba_req_sent, deep_sleep_enter, fw_sysassert_fatal, isr_880b50__dispatch_causes, isr_ucode_fault, ka_necessity_detector__task, lmac_if__ucode_event_dispatch, mac__program_gp_timer, mac__read_tsf_hi, periodic_service__run
 */
	.section .text.mac_read_tsf64,"ax",@progbits
	.global mac_read_tsf64
mac_read_tsf64:
	.global L_8e4840
L_8e4840:
	breq_s r2,0,L_8e484e
	.global L_8e4842
L_8e4842:
	mov_s r0,0x886e80
L_8e4848:
	ld_s r0,[r0,0x34]
L_8e484a:
	bbit0 r0,0x1f,L_8e4842
	.global L_8e484e
L_8e484e:
	mov_s r2,0x886e80
L_8e4854:
	ld_s r3,[r2,0x3c]
L_8e4856:
	st_s r3,[r1,0x4]
L_8e4858:
	ld_s r0,[r2,0x38]
L_8e485a:
	st_s r0,[r1]
L_8e485c:
	ld_s r0,[r2,0x3c]
L_8e485e:
	brne r3,r0,L_8e484e
L_8e4862:
	j_s [blink]
