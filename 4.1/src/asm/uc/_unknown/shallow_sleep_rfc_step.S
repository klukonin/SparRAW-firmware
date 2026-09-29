/* shallow_sleep_rfc_step @ 0x9219c8, 128 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки uc_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: perform_shallow_sleep
 * Зовёт сам: mac__program_deadline_slack, mac__program_rf_mode, mac__set_rf_chain_state, mac__switch_core_and_setup_dma, rfc_ctrl__switch, sxd_hal__read_backoff_status
 */
	.section .text.shallow_sleep_rfc_step,"ax",@progbits
	.global shallow_sleep_rfc_step
shallow_sleep_rfc_step:
	.global L_9219c8
L_9219c8:
	st.a r13,[sp,-0x8]
L_9219cc:
	st blink,[sp, 0x4]
L_9219d0:
	breq.d r0,0x0,L_921a00
L_9219d4:
	mov r13,r1
L_9219d8:
	bl.d L_936d64
L_9219dc:
	mov r0,0x1
L_9219e0:
	breq_s r13,0,L_921a3c
L_9219e2:
	ld r0,[0x801434]
L_9219ea:
	mov_s r1,0x19
L_9219ec:
	bl.d L_930494
L_9219f0:
	mov r2,0x50
L_9219f4:
	ld blink,[sp, 0x4]
L_9219f8:
	j.d [blink]
L_9219fc:
	ld.ab r13,[sp,0x8]
	.global L_921a00
L_921a00:
	bl.d L_936d64
L_921a04:
	mov r0,0x0
L_921a08:
	bl.d L_9296c8
L_921a0c:
	mov r0,0x1
L_921a10:
	ld r1,[0x80087c]
L_921a18:
	bl.d L_92b934
L_921a1c:
	mov r0,0x1
L_921a20:
	bl L_9377bc
L_921a24:
	mov r0,0x3
L_921a28:
	bl.d L_92b9d0
L_921a2c:
	mov r1,0xff
L_921a30:
	ld blink,[sp, 0x4]
L_921a34:
	j.d [blink]
L_921a38:
	ld.ab r13,[sp,0x8]
	.global L_921a3c
L_921a3c:
	ld blink,[sp, 0x4]
L_921a40:
	j.d [blink]
L_921a44:
	ld.ab r13,[sp,0x8]
